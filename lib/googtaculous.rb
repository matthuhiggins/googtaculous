module StrictlyUntyped
  module Googtaculous
    
    GOOGLE_PATHS = {
      'prototype' => 'http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js',
      'effects'   => 'http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/effects.js',
      'dragdrop'  => 'http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/dragdrop.js',
      'controls'  => 'http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/controls.js'
    }
    
    def self.included(base)
      base.send :alias_method_chain, :path_to_javascript, :google unless ActionController::Base.consider_all_requests_local
    end
    
    def path_to_javascript_with_google(source)
      GOOGLE_PATHS[source] || path_to_javascript_without_google(source)
    end
  end
end