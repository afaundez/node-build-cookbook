class Chef
  module NodeBuild
    def node_build_dependencies
      [tar, python, gcc, make].compact
    end

    def python
      version = node['platform_version'].to_i
      if platform?('oracle') && version == 8 then 'python36'
      elsif platform?(*supported_plaftorms) then 'python3'
      end
    end

    def gcc
      case node['platform_family']
      when 'amazon', 'fedora', 'rhel' then 'gcc-c++'
      when 'debian' then 'g++'
      end
    end

    def make
      'make' if platform?(*supported_plaftorms)
    end

    def tar
      'tar' if platform?('amazon')
    end

    def supported_plaftorms
      %w(amazon centos debian fedora oracle ubuntu)
    end
  end
end
