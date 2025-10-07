# we promote the usage of chrony instead of the timesyncd - remove so it does
# not waste space
PACKAGECONFIG:remove = "timesyncd"
