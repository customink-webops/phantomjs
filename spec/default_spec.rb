require 'spec_helper'

describe 'phantomjs::default' do
  context 'on ubuntu' do
    before{ Fauxhai.mock(platform:'ubuntu', version:'12.04') }
    let(:runner){ ChefSpec::ChefRunner.new.converge('phantomjs::default') }

    it 'should install the correct packages' do
      runner.should install_package 'fontconfig'
      runner.should install_package 'libfreetype6'
    end
  end

  context 'on centos' do
    before{ Fauxhai.mock(platform:'centos', version:'6.3') }
    let(:runner){ ChefSpec::ChefRunner.new.converge('phantomjs::default') }

    it 'should install the correct packages' do
      runner.should install_package 'fontconfig'
      runner.should install_package 'freetype'
    end
  end

  context 'on gentoo' do
    before{ Fauxhai.mock(platform:'gentoo', version:'2.1') }
    let(:runner){ ChefSpec::ChefRunner.new.converge('phantomjs::default') }

    it 'should install the correct packages' do
      runner.should install_package 'media-libs/fontconfig'
      runner.should install_package 'media-libs/freetype'
    end
  end

  let(:runner) do
    ChefSpec::ChefRunner.new.converge('phantomjs::default')
  end

  context 'src directory' do
    let(:src_dir) { '/usr/local/src' }

    it 'is created' do
      runner.should create_directory src_dir
    end

    it 'is owned by root:root' do
      runner.directory(src_dir).should be_owned_by('root', 'root')
    end
  end

  it 'should fetch the correct remote_file' do
    runner.should create_remote_file '/usr/local/src/phantomjs-1.9.0-linux-i386.tar.bz2'
  end

  it 'should extract the binary' do
    runner.should execute_command 'tar -xvjf /usr/local/src/phantomjs-1.9.0-linux-i386.tar.bz2 -C /usr/local/'
  end

  it 'should symlink the binary to /usr/local/bin' do
    runner.should create_link '/usr/local/bin/phantomjs'
    runner.link('/usr/local/bin/phantomjs').should link_to('/usr/local/phantomjs-1.9.0-linux-i386/bin/phantomjs')
  end
end
