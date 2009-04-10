module StrictlyUntyped
  module Googtaculous
    def self.included(base)
      base.class_eval do
        alias_method_chain(:path_to_javascript, :google) unless ActionController::Base.consider_all_requests_local
      end
    end

    def path_to_javascript_with_google(source)
      google_path(source) || path_to_javascript_without_google(source)
    end

    private
      GOOGLE_PATHS = {
        'prototype' => 'prototype/1.6.0.3/prototype.js',
        'effects'   => 'scriptaculous/1.8.2/effects.js',
        'dragdrop'  => 'scriptaculous/1.8.2/dragdrop.js',
        'controls'  => 'scriptaculous/1.8.2/controls.js'
      }

      def google_path(source)
        if GOOGLE_PATHS.include? source
          [@controller.request.protocol, google_ajax_lib_root, GOOGLE_PATHS[source]].join
        end
      end

      GOOGLE_AJAX_LIB_ROOT = "ajax.googleapis.com/ajax/libs/".freeze
      def google_ajax_lib_root
        GOOGLE_AJAX_LIB_ROOT
      end
  end
end