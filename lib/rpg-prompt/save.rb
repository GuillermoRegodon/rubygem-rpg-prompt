module Save
  def self.file_name_format(short_name)
    "sw." + short_name + ".marshal"
  end

  def self.file_scene_format(short_name)
    "ss." + short_name + ".marshal"
  end

  def self.save_exist?(short_name)
    File.exist?(Save.file_name_format(short_name))
  end

  def self.save_sheet(short_name, sheet)
    file_name = Save.file_name_format(short_name)
    file_handler = File.open(file_name, "w") {|to_file| Marshal.dump(sheet, to_file)}
    file_handler.close
    if File.exist?(file_name)
      return 0
    else
      return -1
    end
  end  

  def self.load_sheet(short_name)
    file_name = Save.file_name_format(short_name)
    Save.load(file_name)
  end

  def self.delete_sheet(short_name)
    file_name = Save.file_name_format(short_name)
    Save.delete(file_name)
  end

  def self.list_warriors
    ls = Dir.entries(".")
    ls.each do |f|
      m = f.match(/^sw\.(?<name>\w+)\.marshal$/)
      if m
        puts m[:name]
      end
    end
  end

  @pool_file_name = "pool.marshal"

  def self.save_pool(pool)
    file_handler = File.open(@pool_file_name, "w") {|to_file| Marshal.dump(pool, to_file)}
    file_handler.close
    if File.exist?(@pool_file_name)
      return 0
    else
      return -1
    end
  end

  def self.load_pool
    if File.exist?(@pool_file_name)
      Save.load(@pool_file_name)
    end
  end

  def self.delete_pool
    if File.exist?(@pool_file_name)
      File.delete(@pool_file_name)
    end
  end

  @backup_file_name = ".backup.marshal"

  def self.save_backup(pool)
    file_handler = File.open(@backup_file_name, "w") {|to_file| Marshal.dump(pool, to_file)}
    file_handler.close
    if File.exist?(@backup_file_name)
      return 0
    else
      return -1
    end
  end

  def self.load_backup
    Save.load(@backup_file_name)
  end

  def self.delete_scene(short_name)
    file_name = Save.file_scene_format(short_name)
    Save.delete(file_name)
  end

  def self.delete_backup
    File.delete(@backup_file_name)
  end

  def self.save_scene(pool, name)
    file_name = file_scene_format(name)
    file_handler = File.open(file_name, "w") {|to_file| Marshal.dump(pool, to_file)}
    file_handler.close
    if File.exist?(file_name)
      return 0
    else
      return -1
    end
  end

  def self.load_scene(name)
    Save.load(file_scene_format(name))
  end

  def self.list_scenes
    ls = Dir.entries(".")
    ls.each do |f|
      m = f.match(/^ss\.(?<name>\w+)\.marshal$/)
      if m
        puts m[:name]
      end
    end
  end

  def self.load(file_name)
    if File.exist?(file_name)
      begin
        file_handler = File.open(file_name, "r")
        sheet = Marshal.load(file_handler)
        file_handler.close
      rescue
        sheet = false
      end
    else
      sheet = nil
    end
    sheet
  end

  def self.delete(file_name)
    if File.exist?(file_name)
      File.delete(file_name)
    else
      -1
    end
  end
end