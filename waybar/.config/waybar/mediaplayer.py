#!/usr/bin/env python3
import gi

gi.require_version("Playerctl", "2.0")
import argparse
import json
import logging
import os
import signal
import sys
from typing import List

import gi
from gi.repository import GLib, Playerctl # type: ignore
from gi.repository.Playerctl import Player # type: ignore

logger = logging.getLogger(__name__)


def signal_handler(sig, frame):
    logger.info("Received signal to stop, exiting")
    sys.stdout.write("\n")
    sys.stdout.flush()
    # loop.quit()
    sys.exit(0)


class PlayerManager:
    def __init__(self, selected_player=None, excluded_player=[]):
        self.manager = Playerctl.PlayerManager()
        self.loop = GLib.MainLoop()
        self.manager.connect(
            "name-appeared", lambda *args: self.on_player_appeared(*args)
        )
        self.manager.connect(
            "player-vanished", lambda *args: self.on_player_vanished(*args)
        )

        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        signal.signal(signal.SIGPIPE, signal.SIG_DFL)
        self.selected_player = selected_player
        self.excluded_player = excluded_player.split(",") if excluded_player else []

        self.init_players()

    def init_players(self):
        for player in self.manager.props.player_names:
            if player.name in self.excluded_player:
                continue
            if self.selected_player is not None and self.selected_player != player.name:
                logger.debug(f"{player.name} is not the filtered player, skipping it")
                continue
            self.init_player(player)

    def run(self):
        logger.info("Starting main loop")
        self.loop.run()

    def init_player(self, player):
        logger.info(f"Initialize new player: {player.name}")
        player = Playerctl.Player.new_from_name(player)
        player.connect("playback-status", self.on_playback_status_changed, None)
        player.connect("metadata", self.on_metadata_changed, None)
        self.manager.manage_player(player)
        self.on_metadata_changed(player, player.props.metadata)

    def get_players(self) -> List[Player]:
        return self.manager.props.players

    def write_output(self, text, player):
        logger.debug(f"Writing output: {text}")

        output = {
            "text": text,
            "class": "custom-" + player.props.player_name,
            "alt": player.props.player_name,
        }

        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()

    def clear_output(self):
        sys.stdout.write("\n")
        sys.stdout.flush()

    def on_playback_status_changed(self, player, status, _=None):
        logger.debug(
            f"Playback status changed for player {player.props.player_name}: {status}"
        )
        self.on_metadata_changed(player, player.props.metadata)

    def get_first_playing_player(self):
        players = self.get_players()
        logger.debug(f"Getting first playing player from {len(players)} players")
        if len(players) > 0:
            # if any are playing, show the first one that is playing
            # reverse order, so that the most recently added ones are preferred
            for player in players[::-1]:
                if player.props.status == "Playing":
                    return player
            # if none are playing, show the first one
            return players[0]
        else:
            logger.debug("No players found")
            return None

    def show_most_important_player(self):
        logger.debug("Showing most important player")
        # show the currently playing player
        # or else show the first paused player
        # or else show nothing
        current_player = self.get_first_playing_player()
        if current_player is not None:
            self.on_metadata_changed(current_player, current_player.props.metadata)
        else:
            self.clear_output()

    def scroll_text(self, text, width=25, spacer="   "):
        if len(text) <= width:
            yield text.ljust(width)
            return

        padded = text + spacer
        scroll_text = padded + padded[:width]  
        while True:
            for i in range(len(padded)):
                yield scroll_text[i:i+width]

    scoll_generator = None
    scroll_timeout_id = None

    def on_metadata_changed(self, player, metadata, _=None):
        artist = player.get_artist().replace("&", "&amp;")
        title = player.get_title().replace("&", "&amp;")

        if (
            player.props.player_name == "spotify"
            and "mpris:trackid" in metadata.keys()
            and ":ad:" in player.props.metadata["mpris:trackid"]
        ):
            track_info = "Advertisement"
        elif artist and title:
            track_info = f"{artist} - {title}"
        else:
            track_info = title or ""

        if player.props.status == "Playing":
            track_info = " " + track_info
        else:
            track_info = " " + track_info

        # Cancel previous timer if any
        if self.scroll_timeout_id is not None:
            GLib.source_remove(self.scroll_timeout_id)
            self.scroll_timeout_id = None

        # Create new scroll generator and assign it to self
        self.scroll_generator = self.scroll_text(track_info)

        def update():
            try:
                self.write_output(next(self.scroll_generator), player)
            except StopIteration:
                return False
            return True  # repeat

        # Start the scrolling timer
        self.scroll_timeout_id = GLib.timeout_add(500, update)


#    def on_metadata_changed(self, player, metadata, _=None):
#        logger.debug(f"Metadata changed for player {player.props.player_name}")
#        player_name = player.props.player_name
#        artist = player.get_artist()
#        artist = artist.replace("&", "&amp;")
#        title = player.get_title()
#        title = title.replace("&", "&amp;")
#
#        track_info = ""
#        if (
#            player_name == "spotify"
#            and "mpris:trackid" in metadata.keys()
#            and ":ad:" in player.props.metadata["mpris:trackid"]
#        ):
#            track_info = "Advertisement"
#        elif artist is not None and title is not None:
#            track_info = f"{artist} - {title}"
#        else:
#            track_info = title
#
#        if track_info:
#            if player.props.status == "Playing":
#                track_info = " " + track_info
#            else:
#                track_info = " " + track_info
#        # only print output if no other player is playing
#        current_playing = self.get_first_playing_player()
#        if (
#            current_playing is None
#            or current_playing.props.player_name == player.props.player_name
#        ):
#            self.write_output(track_info, player)
#        else:
#            logger.debug(
#                f"Other player {current_playing.props.player_name} is playing, skipping"
#            )

    def on_player_appeared(self, _, player):
        logger.info(f"Player has appeared: {player.name}")
        if player.name in self.excluded_player:
            logger.debug(
                "New player appeared, but it's in exclude player list, skipping"
            )
            return
        if player is not None and (
            self.selected_player is None or player.name == self.selected_player
        ):
            self.init_player(player)
        else:
            logger.debug(
                "New player appeared, but it's not the selected player, skipping"
            )

    def on_player_vanished(self, manager, player_name):
        logger.info(f"Player {player_name.name} has vanished")
        
        # Cancel scroll timer
        if self.scroll_timeout_id is not None:
            GLib.source_remove(self.scroll_timeout_id)
            self.scroll_timeout_id = None
        
        # Clear output immediately
        self.clear_output()
        
        # Also check if we should show another player
        self.show_most_important_player()


def parse_arguments():
    parser = argparse.ArgumentParser()

    # Increase verbosity with every occurrence of -v
    parser.add_argument("-v", "--verbose", action="count", default=0)

    parser.add_argument("-x", "--exclude", "- Comma-separated list of excluded player")

    # Define for which player we"re listening
    parser.add_argument("--player")

    parser.add_argument("--enable-logging", action="store_true")

    return parser.parse_args()


def main():
    arguments = parse_arguments()

    # Initialize logging
    if arguments.enable_logging:
        logfile = os.path.join(
            os.path.dirname(os.path.realpath(__file__)), "media-player.log"
        )
        logging.basicConfig(
            filename=logfile,
            level=logging.DEBUG,
            format="%(asctime)s %(name)s %(levelname)s:%(lineno)d %(message)s",
        )

    # Logging is set by default to WARN and higher.
    # With every occurrence of -v it's lowered by one
    logger.setLevel(max((3 - arguments.verbose) * 10, 0))

    logger.info("Creating player manager")
    if arguments.player:
        logger.info(f"Filtering for player: {arguments.player}")
    if arguments.exclude:
        logger.info(f"Exclude player {arguments.exclude}")

    player = PlayerManager(arguments.player, arguments.exclude)
    player.run()


if __name__ == "__main__":
    main()
