require 'spec_helper'

describe 'phantomjs::source' do
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

    runner.converge('phantomjs::source')
  }

  it 'includes the `structure` recipe' do
    expect(runner).to include_recipe('phantomjs::structure')
  end

  it "should install phantomjs via ark" do
    runner.should install_ark "phantomjs"
  end
end
