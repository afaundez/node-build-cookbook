# Inspec test for recipe node_build::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

node_build_bin = '/usr/local/bin/node-build'
expected_owner = 'root'
expected_group = os.debian? ? 'staff' : expected_owner

control 'standalone install' do
  node_build_home = ::File.join '/usr/local/share/node-build'
  describe directory(node_build_home) do
    it { should exist }
    its('owner') { should eq expected_owner }
    its('group') { should eq expected_group }
  end

  describe file(node_build_bin) do
    it { should exist }
    its('owner') { should eq expected_owner }
    its('group') { should eq expected_group }
  end

  describe command("#{node_build_bin} --version") do
    its('stdout') { should match /^node-build/ }
    its('exit_status') { should eq 0 }
  end
end

control 'build a node version with a node-build binary' do
  node_versions_home = '/tmp/node-build-versions'
  node_version = '24.3.0'

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
