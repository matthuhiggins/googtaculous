module StrictlyUntyped
  module Googtaculous    
    def self.included(base)
      base.send(:alias_method_chain, :path_to_javascript, :google) unless ActionController::Base.consider_all_requests_local
    end

    def path_to_javascript_with_google(source)
      google_path(source) || path_to_javascript_without_google(source)
    end

    private
      GOOGLE_PATHS = {
        'prototype' => 'prototype/1.6.0.2/prototype.js',
        'effects'   => 'scriptaculous/1.8.1/effects.js',
        'dragdrop'  => 'scriptaculous/1.8.1/dragdrop.js',
        'controls'  => 'scriptaculous/1.8.1/controls.js'
      }

      def google_path(source)
        if GOOGLE_PATHS.include? source
          [@controller.request.protocol, google_ajax_lib_root, GOOGLE_PATHS[source]].join
        end
      end

      def google_ajax_lib_root
        "ajax.googleapis.com/ajax/libs/"
      end
  end
end