# frozen_string_literal: true

require 'minitest/autorun'

class TestWebBuild < Minitest::Test
  def test_web_index_html_exists
    index_path = File.expand_path('../web/index.html', __dir__)
    assert File.exist?(index_path), 'web/index.html should exist'

    content = File.read(index_path)
    assert_includes content, 'gameCanvas'
    assert_includes content, 'Dog Dash Deluxe'
    assert_includes content, 'game.js'
  end

  def test_web_game_js_exists
    game_js_path = File.expand_path('../web/game.js', __dir__)
    assert File.exist?(game_js_path), 'web/game.js should exist'

    content = File.read(game_js_path)
    assert_includes content, 'class Player'
    assert_includes content, 'class Soundwave'
    assert_includes content, 'class EvilCat'
    assert_includes content, 'checkAABB'
  end

  def test_github_pages_workflow_exists
    workflow_path = File.expand_path('../.github/workflows/deploy.yml', __dir__)
    assert File.exist?(workflow_path), '.github/workflows/deploy.yml should exist'

    content = File.read(workflow_path)
    assert_includes content, 'Deploy to GitHub Pages'
    assert_includes content, 'actions/deploy-pages@v4'
    assert_includes content, 'path: \'./web\''
  end
end
