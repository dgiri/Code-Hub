class Mp3PlayerGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  class_option :swfobject, :type => :boolean, :default => true, :desc => 'Use included swfobject library'
  class_option :initializer, :type => :boolean, :default => true,
               :desc => 'Add mp3_player.yml initializer for global customizations'

  def copy_player
    copy_file 'player.swf', 'public/player.swf'
  end
  
  def copy_audio_player_js
    if options[:swfobject]
      copy_file 'audio-player.js', 'public/javascripts/audio-player.js'
    else
      copy_file 'audio-player-noswfobject.js', 'public/javascripts/audio-player-noswfobject.js'
    end
  end

  def copy_initializer
    if options[:initializer]
      copy_file 'mp3_player.yml', 'config/mp3_player.yml'
    end
  end
end
