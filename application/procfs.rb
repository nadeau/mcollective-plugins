class MCollective::Application::Procfs<MCollective::Application
  description "Linux /proc filesystem agent"
    usage <<-END_OF_USAGE
mco procfs [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]

The ACTION can be one of the following:

    load    - returns host load
    get     - generic getter
    set     - generic setter
    END_OF_USAGE

  option :csv,
  :description    => "Output result in CSV format",
  :arguments      => ["--csv"],
  :type           => :bool

  option :key,
  :description    => "Proc file",
  :arguments      => ["--key KEY"]

  option :value,
  :description    => "New Value",
  :arguments      => ["--value VALUE"]

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift

      unless configuration[:command].match(/^(load|get|set)$/)
        raise "Action must be one of load, get or set"
      end
    else
      raise "Please specify an action."
    end
  end

  def main
    mc = rpcclient("procfs", :options => options)

    case configuration[:command]

    when "load"

      if configuration[:csv]
        format = '"%s","%s","%s","%s","%s","%s"' + "\n"
      else
        format = "%-12s %6s %6s %6s %8s %6s\n"
      end

      printf( format, "Host", "Load1", "Load5", "Load15", "Running", "Procs" )

      mc.load(configuration) do |resp|
        begin
          printf( format,
                  resp[:senderid].upcase,
                  resp[:body][:data][:load1],
                  resp[:body][:data][:load5],
                  resp[:body][:data][:load15],
                  resp[:body][:data][:running],
                  resp[:body][:data][:processes] )
          
        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "get"

      if configuration[:csv]
        format = '"%s","%s","%s"' + "\n"
      else
        format = "%-12s %-12s %-20s\n"
      end

      printf( format, "Host", "Key", "Value" )

      mc.get(configuration) do |resp|
        begin
          printf( format,
                  resp[:senderid].upcase,
                  resp[:body][:data][:key],
                  resp[:body][:data][:value] )

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "set"

      if configuration[:csv]
        format = '"%s","%s","%s"' + "\n"
      else
        format = "%-12s %-12s %-20s\n"
      end

      printf( format, "Host", "Key", "Value" )

      mc.set(configuration) do |resp|
        begin
          printf( format,
                  resp[:senderid].upcase,
                  resp[:body][:data][:key],
                  resp[:body][:data][:value] )

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    end
    mc.disconnect
    printrpcstats
    end
end
