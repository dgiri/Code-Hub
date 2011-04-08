require "mp3_player/view_helper"
require "mp3_player/layout_helper"
# includes the view and layout helpers to ActionView::Base
ActionView::Base.send(:include, Mp3Player::ViewHelper)
ActionView::Base.send(:include, Mp3Player::LayoutHelper)
