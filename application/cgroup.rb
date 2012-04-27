class MCollective::Application::Cgroup<MCollective::Application
  description "Linux Control Groups agent"
    usage <<-END_OF_USAGE
mco cgroup [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]

The ACTION can be one of the following:

    list    - returns list of active control groups
    blkio   - returns cgroup info about Block I/O
    cpu     - returns cgroup info about CPU Scheduling
    memory  - returns cgroup info about Memory Use
    END_OF_USAGE

  option :csv,
  :description    => "Output result in CSV format",
  :arguments      => ["--csv"],
  :type           => :bool

  option :cgroup,
  :description    => "Single Group to report",
  :arguments      => ["--cgroup GROUP"]

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift

      unless configuration[:command].match(/^(list|blkio|cpu|memory)$/)
        raise "Action must be one of list, blkio, cpu or memory"
      end
    else
      raise "Please specify an action."
    end
  end

  def main
    mc = rpcclient("cgroup", :options => options)

    # Hardcoded for my environment
    mc.collective = 'LXCHosts';

    case configuration[:command]

    when "list"

      if configuration[:csv]
        format = '"%s","%s"' + "\n";
      else
        format = "%-12s %-20s\n";
      end

      printf( format, "Host", "Group" );

      mc.list(configuration) do |resp|
        begin
          resp[:body][:data][:cgroups].sort.each do |cgroup|
            printf( format,
                    resp[:senderid].upcase,
                    cgroup )
          end

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "blkio"

      if configuration[:csv]
        format = '"%s","%s","%s"' + "\n";
      else
        format = "%-12s %20s %8s\n";
      end

      printf( format, "Host", "Group", "Weight" );

      mc.blkio(configuration) do |resp|
        begin
          resp[:body][:data].keys.sort.each do |cgroup|
            printf( format,
                    resp[:senderid].upcase,
                    cgroup,
                    resp[:body][:data][cgroup][:weight] )
          end

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "cpu"

      if configuration[:csv]
        format = '"%s","%s","%s"' + "\n";
      else
        format = "%-12s %20s %8s\n";
      end

      printf( format, "Host", "Group", "Shares" );

      mc.cpu(configuration) do |resp|
        begin
          resp[:body][:data].keys.sort.each do |cgroup|
            printf( format,
                    resp[:senderid].upcase,
                    cgroup,
                    resp[:body][:data][cgroup][:shares] )
          end

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "memory"

      if configuration[:csv]
        format = '"%s","%s","%s","%s","%s"' + "\n";
      else
        format = "%-12s %20s %8s %8s %8s\n";
      end

      printf( format, "Host", "Group", "Used", "Max", "Limit" );

      mc.memory(configuration) do |resp|
        begin
          resp[:body][:data].keys.sort.each do |cgroup|
            printf( format,
                    resp[:senderid].upcase,
                    cgroup,
                    resp[:body][:data][cgroup][:used],
                    resp[:body][:data][cgroup][:max],
                    resp[:body][:data][cgroup][:limit] )
          end

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    end
    mc.disconnect
    printrpcstats
    end
end
