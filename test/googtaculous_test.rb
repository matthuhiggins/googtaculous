require File.dirname(__FILE__) + '/helper'

RequestMock = Struct.new("Request", :protocol)

class GoogtaculousTest < ActionView::TestCase
  ActionController::Base.consider_all_requests_local = false
  include StrictlyUntyped::Googtaculous

  def setup
    @controller = Class.new do
      attr_accessor :request
    end
    @controller = @controller.new
  end
  
  def test_normal_path_when_unrecognized
    assert_equal "/javascripts/foo.js", path_to_javascript('foo')
  end    
  
  def test_supported_libraries_use_google_api
    @controller.request = RequestMock.new('')
    assert_match /ajax.googleapis.com/, path_to_javascript('prototype')
    assert_match /ajax.googleapis.com/, path_to_javascript('effects')
    assert_match /ajax.googleapis.com/, path_to_javascript('dragdrop')
    assert_match /ajax.googleapis.com/, path_to_javascript('controls')
  end
  
  def test_http_protocol_used_when_non_ssl_request
    @controller.request = RequestMock.new('http://')
    assert_match /^http:/, path_to_javascript('prototype')
  end

  def test_https_protocol_used_when_ssl_request
    @controller.request = RequestMock.new('https://')
    assert_match /^https:/, path_to_javascript('prototype')
  end
  
  def test_w
    @controller.request = RequestMock.new('http://')
    javascripts = javascript_include_tag(:defaults)
    %w(prototype effects dragdrop controls).each do |library|
      assert javascripts.include?(library)
    end
  end
end
