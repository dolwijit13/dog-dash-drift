# frozen_string_literal: true

require 'minitest/autorun'

class TestWebBuild < Minitest::Test
  def test_web_index_html_exists
    index_path = File.expand_path('../web/index.html', __dir__)
    assert File.exist?(index_path), 'web/index.html should exist'

    content = File.read(index_path)
    assert_includes content, 'gameCanvas'
    assert_includes content, 'Dog Dash Deluxe'
    assert_includes content, 'ruby.wasm'
    assert_includes content, 'web_gosu_bridge.js'
  end

  def test_web_gosu_bridge_js_exists
    bridge_js_path = File.expand_path('../web/web_gosu_bridge.js', __dir__)
    assert File.exist?(bridge_js_path), 'web/web_gosu_bridge.js should exist'

    content = File.read(bridge_js_path)
    assert_includes content, 'WebGosu'
    assert_includes content, 'drawRect'
    assert_includes content, 'drawLine'
  end

  def test_github_pages_workflow_bundling_ruby_source
    workflow_path = File.expand_path('../.github/workflows/deploy.yml', __dir__)
    assert File.exist?(workflow_path), '.github/workflows/deploy.yml should exist'

    content = File.read(workflow_path)
    assert_includes content, 'Deploy to GitHub Pages'
    assert_includes content, 'cp main.rb web/'
    assert_includes content, 'cp -r lib web/'
    assert_includes content, 'actions/deploy-pages@v4'
  end
end
