require 'googtaculous'

ActionView::Base.class_eval do
  include StrictlyUntyped::Googtaculous
end
