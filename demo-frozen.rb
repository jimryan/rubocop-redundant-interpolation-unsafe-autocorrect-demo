frozen_string = 'foo'.freeze

dupd_via_interpolation = "#{frozen_string}"

dupd_via_interpolation << ' bar'

print "#{dupd_via_interpolation}\n"
