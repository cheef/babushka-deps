class Nginx < Struct.new(:template)

  class Sites < Struct.new(:base_path, :kind, :template)

    def include? site_name
      not path.glob(site_name).empty?
    end

    def path
      base_path/"sites-#{kind}"
    end

    def create template, options = {}
      name =  options[:to]
      build   template, options
      enable! name rescue false
    end

    def build template, options = {}
      render_erb template, { :sudo => !path.writable?, :to => path/options.delete(:to) }.merge!(options)
    end

    def method_missing method, *args, &block
      template.send method, *args, &block
    end

    def enable! site_name
      raise "Site configuration `#{site_name}` not exists" unless include?(site_name)

      enabled_sites = self.class.new(base_path, :enabled, template)
      enabled_sites.disable!(site_name) rescue true

      log_block "Enabling `#{site_name}` site" do
        shell "ln -s #{path/site_name} #{enabled_sites.path/site_name}", :sudo => !enabled_sites.path.writable?
      end
    end

    def disable! site_name
      raise "Site configuration `#{site_name}` not enabled" unless include?(site_name)

      filepath = path/site_name
      log_block "Disabling `#{site_name}` site" do
        shell "rm -rf #{filepath}", :sudo => !filepath.writable?
      end
    end

    def enabled_path
      base_path/"sites-enabled"
    end

  end

  def sites kind = :available
    Sites.new(base_path, kind, template)
  end

  def base_path
    '/etc/nginx'
  end

  def restart!
    log_shell "Restarting nginx", "/etc/init.d/nginx restart", :sudo => true
  end

  def config_path
    base_path/'nginx.conf'
  end

  def method_missing method, *args, &block
    template.send method, *args, &block
  end

end

def nginx
  @nginx ||= Nginx.new self
end
