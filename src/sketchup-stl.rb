# Copyright 2012-2014 Trimble Navigation Ltd.
#
# License: Apache License, Version 2.0
#
# A SketchUp Ruby Extension that adds STL (STereoLithography) file format
# import and export. More info at https://github.com/SketchUp/sketchup-stl

require 'sketchup.rb'
require 'extensions.rb'

module CommunityExtensions
  module STL

    # In SU2014, with Ruby 2.0 the __FILE__ constant return an UTF-8 string with
    # incorrect encoding label which will cause load errors when the file path
    # contain multi-byte characters. This happens when the user has non-english
    # characters in their username.
    current_path = File.dirname(__FILE__)
    if current_path.respond_to?(:force_encoding)
      current_path.force_encoding("UTF-8")
    end

    PLUGIN_ROOT_PATH    = current_path.freeze
    PLUGIN_PATH         = File.join(PLUGIN_ROOT_PATH, 'sketchup-stl').freeze
    PLUGIN_STRINGS_PATH = File.join(PLUGIN_PATH, 'strings').freeze

    Sketchup::require File.join(PLUGIN_PATH, 'translator')
    options = {
      :custom_path => PLUGIN_STRINGS_PATH,
      :debug => false
    }
    @translator = Translator.new('STL.strings', options)

    # Method for easy access to the translator instance to anything within this
    # project.
    #
    # @example
    #   STL.translate('Hello World')
    def self.translate(string)
      @translator.get(string)
    end

    extension = SketchupExtension.new(
      STL.translate('STL Import & Export'),
      File.join(PLUGIN_PATH, 'loader.rb')
    )

    extension.description = STL.translate(
      'Adds STL file format import and export. ' <<
      'This is an open source project sponsored by the SketchUp team. More ' <<
      'info and updates at https://github.com/SketchUp/sketchup-stl'
    )
    extension.version = '2.1.4'
    extension.copyright = '2012-2014 Trimble Navigation, ' <<
      'released under Apache 2.0'
    extension.creator = 'J. Foltz, N. Bromham, K. Shroeder, SketchUp Team'

    Sketchup.register_extension(extension, true)

  end # module STL
end # module CommunityExtensions
