module WRKFLO
  class NFSStep < Step
    add_alias :nfs

    property :host,         required: true, type: String
    property :remote_path,  required: true, type: String
    property :local_path,   required: true, type: String

    def run
      log "Mounting  #{config.host}:#{config.remote_path}  at  #{config.local_path}"
      `mount -t nfs #{config.host}:#{config.remote_path} #{config.local_path}`
    end

    def unrun
      log "Unmounting  #{config.host}:#{config.remote_path}  from  #{config.local_path}"
      `umount #{config.local_path}`
    end
  end
end
