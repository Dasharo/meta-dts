# we promote the usage of chrony instead of the timesyncd - remove so it does
# not wast space
PACKAGECONFIG:remove = "timesyncd"
