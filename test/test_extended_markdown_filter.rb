require "test_helper"

class HTML::Pipeline::ExtendedMarkdownFilterTest < Minitest::Test
  def fixture(name)
    File.open(File.join("#{File.expand_path(File.dirname(__FILE__))}", "fixtures", name)).read
  end

  def test_command_line
    doc = ExtendedMarkdownFilter.to_document(fixture("command_line.md"), {})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('pre').size
    assert_equal 2, doc.css('span.command').size
    assert_equal 1, doc.css('span.comment').size
    assert_equal 2, doc.css('em').size
    assert_equal 1, doc.css('span.output').size

    assert_equal 0, doc.css('.command-line a').size
  end

  def test_helper
    doc = ExtendedMarkdownFilter.to_document(fixture("helper.md"), {})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.helper').size
    assert_equal 1, doc.css('h4.header').size
    assert_equal 1, doc.css('a').size
    assert_equal 1, doc.css('div.content').size
  end

  def test_intro
    doc = ExtendedMarkdownFilter.to_document(fixture("intro.md"), {})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.intro').size
    assert_equal 1, doc.css('a').size # the inner Markdown converted!
  end

  def test_block_intro
    doc = ExtendedMarkdownFilter.to_document(fixture("block_intro.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.intro').size
    assert_equal 1, doc.css('a').size # the inner Markdown converted!
  end

  def test_intro_conversion
    doc = ExtendedMarkdownFilter.to_document(fixture("intro.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.intro').size
    assert_equal 1, doc.css('a').size # the inner Markdown converted!
  end

  def test_os_blocks
    doc = ExtendedMarkdownFilter.to_document(fixture("os_blocks.md"), {})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.platform-mac').size
    assert_equal 1, doc.css('div.platform-windows').size
    assert_equal 1, doc.css('div.platform-linux').size
    assert_equal 1, doc.css('div.platform-all').size
    # the inner Markdown converted!
    assert_equal 3, doc.css('ol').size
    assert_equal 2, doc.css('a').size
    assert_equal 1, doc.css('em').size
  end

  def test_block_os_blocks
    doc = ExtendedMarkdownFilter.to_document(fixture("block_os_blocks.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.platform-mac').size
    assert_equal 1, doc.css('div.platform-windows').size
    assert_equal 1, doc.css('div.platform-linux').size
    assert_equal 1, doc.css('div.platform-all').size
    # the inner Markdown converted!
    assert_equal 3, doc.css('ol').size
    assert_equal 2, doc.css('a').size
    assert_equal 1, doc.css('em').size
  end

  def test_block_conversion
    doc = ExtendedMarkdownFilter.to_document(fixture("os_blocks.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.platform-mac').size
    assert_equal 1, doc.css('div.platform-windows').size
    assert_equal 1, doc.css('div.platform-linux').size
    assert_equal 1, doc.css('div.platform-all').size
    # the inner Markdown converted!
    assert_equal 3, doc.css('ol').size
    assert_equal 2, doc.css('a').size
    assert_equal 1, doc.css('em').size
  end

  def test_admonition
    doc = ExtendedMarkdownFilter.to_document(fixture("admonition.md"), {})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.tip').size
    assert_equal 1, doc.css('div.warning').size
    assert_equal 1, doc.css('div.error').size
    # the inner Markdown converted!
    assert_equal 1, doc.css('strong').size
    assert_equal 1, doc.css('del').size
  end

  def test_block_admonition
    doc = ExtendedMarkdownFilter.to_document(fixture("block_admonition.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.tip').size
    assert_equal 1, doc.css('div.note').size
    assert_equal 1, doc.css('div.warning').size
    assert_equal 1, doc.css('div.danger').size
    # the inner Markdown converted!
    assert_equal 1, doc.css('strong').size
    assert_equal 1, doc.css('del').size
  end

  def test_admonition_conversion
    doc = ExtendedMarkdownFilter.to_document(fixture("admonition.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('div.tip').size
    assert_equal 1, doc.css('div.note').size
    assert_equal 1, doc.css('div.warning').size
    assert_equal 1, doc.css('div.danger').size
    # the inner Markdown converted!
    assert_equal 1, doc.css('strong').size
    assert_equal 1, doc.css('del').size
  end

  def test_octicon
    doc = ExtendedMarkdownFilter.to_document(fixture("octicon.md"), {})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('span.octicon-cat').size
    assert_match "{{ octicon dog", doc.to_s
    assert_match '<p><a href="http://alink.com">Click <span class="octicon octicon-gear" aria-label="Settings " title="Settings "></span></a></p>', doc.to_s
  end

  def test_block_octicon
    doc = ExtendedMarkdownFilter.to_document(fixture("block_octicon.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('span.octicon-cat').size
    assert_match "[[ octicon dog", doc.to_s
    assert_match '<p><a href="http://alink.com">Click <span class="octicon octicon-gear" aria-label="Settings " title="Settings "></span></a></p>', doc.to_s
  end

  def test_oction_conversion
    doc = ExtendedMarkdownFilter.to_document(fixture("octicon.md"), {:emf_use_blocks => true})
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)

    assert_equal 1, doc.css('span.octicon-cat').size
    assert_match "{{ octicon dog", doc.to_s
    assert_match '<p><a href="http://alink.com">Click <span class="octicon octicon-gear" aria-label="Settings " title="Settings "></span></a></p>', doc.to_s
  end

end
