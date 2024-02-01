require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test 'should return default title' do
    content_for(:title) { 'page'}

    "page | #{I18n.t('piazza')}"
  end

  test 'should return title with content' do
    assert_equal I18n.t('piazza'), title
  end
end