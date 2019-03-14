Facter.add(:rabbitmq_vhosts) do
  setcode do
    hash = {}
    vhosts = Facter::Core::Execution.execute('rabbitmqctl list_vhosts|grep -v ^Listing')
    vhosts.split("\n").each do |vhost|
      queues = Facter::Core::Execution.execute("rabbitmqctl list_queues -p #{vhost}|grep -v ^Listing|awk '{for(i=1;i<NF;i++) printf $i\" \";printf \"\\n\"}'|sed 's/ $//'")
      hash[vhost] = queues.split("\n") 
    end
    hash
  end
end
