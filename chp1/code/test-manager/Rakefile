### ----------------------------------------------------------------------
### Copyright 2007-2008 Alexey Radul.
### ----------------------------------------------------------------------
### This file is part of Test Manager.
### 
### Test Manager is free software; you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation, either version 3 of the License, or
### (at your option) any later version.
### 
### Test Manager is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.
### 
### You should have received a copy of the GNU General Public License
### along with Test Manager.  If not, see <http://www.gnu.org/licenses/>.
### ----------------------------------------------------------------------

# -*- ruby-mode -*-

require 'rake'

task :default => :test

desc "Run the full test suite in MIT Scheme and Guile"
task :test => [ :mit_scheme_test, :guile_test ]

desc "Run the full test suite in MIT Scheme"
task :mit_scheme_test do 
  sh %Q{mit-scheme --batch-mode --eval "(set! load/suppress-loading-message? #t)" --load load.scm --load all-tests.scm --eval "(%exit (run-registered-tests))"}
end

desc "Run the full test suite in Guile"
task :guile_test do
  sh %Q{guile -l load.scm -l all-tests.scm -c "(exit (run-registered-tests))"}
end

desc "Run a demonstration test suite to show off failure reports in MIT Scheme"
task :demo do 
  sh %Q{mit-scheme --batch-mode --eval "(set! load/suppress-loading-message? #t)" --load load.scm --load failure-report-demo.scm --eval "(%exit 0)"}
end

desc "Run a demonstration test suite to show off failure reports in Guile"
task :guile_demo do 
  sh %Q{guile -l load.scm -l failure-report-demo.scm -c "(exit 0)"}
end

desc "Generate html documentation"
task :doc do
  sh "cd #{File.dirname(__FILE__)}/doc/; cat testing.pod | pod2html > testing.html"
end

desc "Delete random temporary files that arise as one works"
task :clean do
  sh "cd #{File.dirname(__FILE__)}; find . -name '*~' | xargs rm -f; find . -name 'actions.log' | xargs rm -f; find . -name 'pod2htm*.tmp' | xargs rm -f; "
end

desc "Prepare a release tarball"
task :release => [:doc, :clean] do
  sh "cd #{File.dirname(__FILE__)}; " + %Q{tar --create --verbose --file ../test-manager-1.2.tar --directory .. --exclude="*.svn*" --exclude=.commitmail --exclude=todo.txt test-manager/}
end
