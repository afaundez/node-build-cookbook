# Inspec test for recipe node_build::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

plugins_home = ::File.join '/tmp', 'plugins'
relative_node_build_bin_path = 'bin/node-build'
username = 'node-build-user'

control 'install node-build without user/owner nor group properties' do
  node_build_home = File.join plugins_home, 'node-build'
  describe directory(node_build_home) do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  node_build_bin = ::File.join node_build_home, relative_node_build_bin_path
  describe file(node_build_bin) do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe command(node_build_bin) do
    it { should exist }
    its('exit_status') { should eq 1 }
  end
end

control 'install node-build with owner and group properties' do
  node_build_home = File.join plugins_home, 'node-build-with-owner'
  describe directory(node_build_home) do
    it { should exist }
    its('owner') { should eq username }
    its('group') { should eq username }
  end

  node_build_bin = ::File.join node_build_home, relative_node_build_bin_path
  describe file(node_build_bin) do
    it { should exist }
    its('owner') { should eq username }
    its('group') { should eq username }
  end

  describe command(node_build_bin) do
    it { should exist }
    its('exit_status') { should eq 1 }
  end
end

control 'install with deprecated user property instead of owner' do
  node_build_home = File.join plugins_home, 'node-build-with-user'
  describe directory(node_build_home) do
    it { should exist }
    its('owner') { should eq username }
    its('group') { should eq username }
  end

  node_build_bin = ::File.join node_build_home, relative_node_build_bin_path
  describe file(node_build_bin) do
    it { should exist }
    its('owner') { should eq username }
    its('group') { should eq username }
  end

  describe command(node_build_bin) do
    it { should exist }
    its('exit_status') { should eq 1 }
  end
end

control 'build a node version with a node-build binary' do
  node_build_home = File.join plugins_home, 'node-build'
  node_build_bin = ::File.join node_build_home, relative_node_build_bin_path
  node_versions_home = '/tmp/node-build-versions'
  node_version = '13.12.0'

  node_home = ::File.join node_versions_home, node_version
  describe command("#{node_build_bin} #{node_version} #{node_home}") do
    its('exit_status') { should eq 0 }
  end

  node_version_home = ::File.join node_versions_home, node_version
  node_bin = ::File.join node_version_home, 'bin', 'node'
  describe file node_bin do
    it { should exist }
  end
end

control 'upgrade node-build using git revision tag' do
  node_build_home = File.join plugins_home, 'node-build-upgraded'

  describe directory(node_build_home) do
    it { should exist }
  end

  describe command("bash -c \"git config --global --add safe.directory #{node_build_home} && cd #{node_build_home} && git rev-parse HEAD\"") do
    its(:stderr) { should eq '' }
    its(:stdout) { should eq "d6a05a7d598dc2ef2f0e5fbccac5123f12eed61e\n" }
  end
end
