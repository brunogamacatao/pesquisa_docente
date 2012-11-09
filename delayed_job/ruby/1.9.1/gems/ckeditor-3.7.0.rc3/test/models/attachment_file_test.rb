require 'test_helper'

class AttachmentFileTest < ActiveSupport::TestCase
  test "Set file content_type and size" do
    @attachemnt = create_attachemnt
    
    # TODO: fix filename parameterization
    if CKEDITOR_BACKEND == :paperclip
      assert_equal @attachemnt.data_file_name, "rails_tar.gz"
    else
      assert_equal @attachemnt.data_file_name, "rails.tar.gz"
    end
    
    assert_equal @attachemnt.data_content_type, "application/x-gzip"
    assert_equal @attachemnt.data_file_size, 6823
    assert_equal @attachemnt.url_thumb, "/assets/ckeditor/filebrowser/images/thumbs/gz.gif"
  end
end
