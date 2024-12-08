#!/bin/sh

# # fail2ban-client status to get all jails, takes about ~70ms
# jails=($(sudo fail2ban-client status | grep "Jail list:" | sed "s/ //g" | awk '{split($2,a,",");for(i in a) print a[i]}'))
#
# out="jail,failed,total,banned,total,banned_ips\n"
#
# for jail in ${jails[@]}; do
#     # slow because fail2ban-client has to be called for every jail (~70ms per jail)
#     status=$(sudo fail2ban-client status ${jail})
#     failed=$(echo "$status" | grep -ioP '(?<=Currently failed:\t)[[:digit:]]+')
#     totalfailed=$(echo "$status" | grep -ioP '(?<=Total failed:\t)[[:digit:]]+')
#     banned=$(echo "$status" | grep -ioP '(?<=Currently banned:\t)[[:digit:]]+')
#     totalbanned=$(echo "$status" | grep -ioP '(?<=Total banned:\t)[[:digit:]]+')
#
#     # Get the banned IPs for the current jail
#     banned_ips=$(sudo fail2ban-client status ${jail} | grep -i "Banned IP list:" | sed 's/Banned IP list://g' | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g')
#
#     # If the banned IPs list contains only the "-" or is empty, set it to "N/A"
#     if [[ "$banned_ips" == "\`-" || -z "$banned_ips" ]]; then
#         banned_ips="N/A"
#     fi
#
#     # Append the results for this jail to the output variable
#     out+="$jail,$failed,$totalfailed,$banned,$totalbanned,\"$banned_ips\"\n"
# done
#
# # Print the output in a well-organized format
# printf "$out" | column -ts $',' | sed -e 's/^/  /'

logfile='/var/log/fail2ban.log'

if ! mapfile -t lines < <(grep -hioP '(\[[a-z-]+\]) ?(?:restore)? (ban|unban)' $logfile | sort | uniq -c); then
    echo "  No stats found"
    exit 1
fi

if [ ${#lines[@]} -eq 0 ]; then
    echo "  No stats found"
    exit 1
fi

mapfile -t lines < <(grep -hioP '(\[[a-z-]+\]) ?(?:restore)? (ban|unban)' $logfile | sort | uniq -c)
jails=($(printf -- '%s\n' "${lines[@]}" | grep -oP '\[\K[^\]]+' | sort | uniq))

out=""
for jail in ${jails[@]}; do
    bans=$(printf -- '%s\n' "${lines[@]}" | grep -iP "[[:digit:]]+ \[$jail\] ban" | awk '{print $1}')
    restores=$(printf -- '%s\n' "${lines[@]}" | grep -iP "[[:digit:]]+ \[$jail\] restore ban" | awk '{print $1}')
    unbans=$(printf -- '%s\n' "${lines[@]}" | grep -iP "[[:digit:]]+ \[$jail\] unban" | awk '{print $1}')
    bans=${bans:-0} # default value
    restores=${restores:-0} # default value
    unbans=${unbans:-0} # default value
    bans=$(($bans+$restores))
    diff=$(($bans-$unbans))
    out+=$(printf "$jail, %+3s bans, %+3s unbans, %+3s active" $bans $unbans $diff)"\n"
done

printf "$out" | column -ts $',' | sed -e 's/^/  /'
