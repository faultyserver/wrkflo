module WRKFLO
  class VagrantStep < Step
    add_alias :vagrant

    property :name,         required: false,                default: nil
    property :vagrant_dir,  required: false, type: String,  default: Profile.options['vagrant_dir']
    property :up_command,   required: false, type: String,  default: 'up'
    property :down_command, required: false, type: String,  default: 'nothing'

    def init
      # If no name is specified, use the directory as a psuedonym.
      config.name ||= "@#{config.vagrant_dir}"
    end


    def run
      log "Ensuring vagrant machine  `#{config.name}`  is up"
      vagrant config.up_command
    end

    def unrun
      case config.down_command
      when 'halt'
        log "Halting vagrant machine  `#{config.name}`."
        vagrant 'halt'
      when 'suspend'
        log "Suspending vagrant machine  `#{config.name}`."
        vagrant 'suspend'
      when 'destroy'
        log "Destroying vagrant machine  `#{config.name}`."
        vagrant 'destroy'
      when 'nothing'
        log "Nothing to do."
      else
        log "Unknown vagrant command  `#{config.down_command}`."
      end
    end


    private

      def vagrant command
        `VAGRANT_CWD=#{config.vagrant_dir} vagrant #{command}`
      end
  end
end
