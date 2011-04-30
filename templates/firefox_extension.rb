meta :firefox_extension do
  accepts_value_for :source

  def id
    @id ||= begin
      shell <<-CMD
cat #{(Babushka::BuildPrefix.p/downloaded_name)/'install.rdf'} | xmlstarlet sel \
-N rdf=http://www.w3.org/1999/02/22-rdf-syntax-ns# \
-N em=http://www.mozilla.org/2004/em-rdf# \
-t -v \
"//rdf:Description[@about='urn:mozilla:install-manifest']/em:id"
CMD
    end
  end

  def extension_exists?
    extension_path.exists?
  end

  def extension_path
    firefox.extensions_dir.p/id
  end

  def downloaded_name= name
    @downloaded_name = name
  end

  def downloaded_name
    @downloaded_name
  end

  template do
    requires 'xmlstarlet.managed'

    setup do
      handle_source source do |resource|
        self.downloaded_name = resource.filename
      end
    end

    met?  { extension_exists? }
    meet do
      log_shell "Installing extension", "cp -r #{Babushka::BuildPrefix.p/downloaded_name} #{firefox.extensions_dir.p/id}",
                :sudo => !firefox.extensions_dir.p.writable?
    end
  end

end