require 'spec_helper'

describe 'phantomjs::default' do
  let(:version)  { '1.0.0' }
  let(:base_url) { 'http://example.com/' }
  let(:src_dir)  { '/src' }
  let(:basename) { 'phantomjs-1.0.0-linux-x86' }

  let(:runner) {
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')

    runner.node.set['phantomjs']['version']  = version
    runner.node.set['phantomjs']['base_url'] = base_url
    runner.node.set['phantomjs']['src_dir']  = src_dir
    runner.node.set['phantomjs']['basename'] = basename

    runner.converge('phantomjs::default')
  }

  it 'includes the `structure` recipe' do
    expect(runner).to include_recipe('phantomjs::structure')
  end

  it 'downloads the tarball' do
    expect(runner).to create_remote_file("#{src_dir}/#{basename}.tar.bz2")
  end

  it 'is owned by the root user' do
    download = runner.remote_file("#{src_dir}/#{basename}.tar.bz2")
    expect(download).to be_owned_by('root', 'root')
  end

  it 'has 0644 permissions' do
    download = runner.remote_file("#{src_dir}/#{basename}.tar.bz2")
    expect(download.mode).to eq('0644')
  end

  it 'notifies the execute resource' do
    download = runner.remote_file("#{src_dir}/#{basename}.tar.bz2")
    expect(download).to notify('execute[phantomjs-install]', :run)
  end

  it 'extracts the binary' do
    expect(runner).to execute_command("tar -xvjf #{src_dir}/#{basename}.tar.bz2 -C /usr/local/")
  end

  it 'notifies the link' do
    command = runner.execute('phantomjs-install')
    expect(command).to notify('link[phantomjs-link]', :create)
  end

  it 'creates the symlink' do
    link = runner.link('phantomjs-link')
    expect(link.target_file).to eq('/usr/local/bin/phantomjs')
    expect(link.to).to eq("/usr/local/#{basename}/bin/phantomjs")
  end
end
