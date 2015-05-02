
# Based on code from https://github.com/cmaclell/Basic-Tweet-analysis-Analyzer


#############################################################################
# Copyright: Christopher MacLellan 2010
# Description: This code adds functions to the string class for calculating
#              the sentivalue of strings. It is not called directly by the
#              tweet-search-analysis.rb program but is included for possible
#              future use.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

#
# In an initializer, you can initialize some global defaults:
#
#   analysisal.loadDefaults
#   analysisal.threshold = 0.1
#
# Then create an instance for usage:
#
#   analyzer = analysisal.new
#   analyzer.getanalysis('I love your service')
#   => :positive
#
# You can make new analyzers with individual thresholds:
#
#   analyzer = analysisal.new(0.9)
#   analyzer.getanalysis('I love your service')
#   => :positive
#   analyzer.getanalysis('I like your service')
#   => :neutral
#
class TextAnalysis

  @@analysishash = Hash.new(0.0)
  @@threshold = 0.0

  def initialize(threshold = nil)
    @threshold = threshold || @@threshold
  end

  #####################################################################
  # Function that returns the analysis value for a given string.
  # This value is the sum of the analysis values of each of the words.
  # Stop words are NOT removed.
  #
  # return:float -- analysis value of the current string
  #####################################################################
  def getScore(string)
    analysis_total = 0.0

    #tokenize the string, also throw away some punctuation
    tokens = string.to_s.downcase.split(/[\s\!\?\.]+/)

    tokens.each do |token|
      analysis_total += @@analysishash[token]
    end
    analysis_total
  end

  def getAnalysis(string)
    score = getScore(string)

    # if less then the negative threshold classify negative
    if score < (-1 * @threshold)
      :negative
    # if greater then the positive threshold classify positive
    elsif score > @threshold
      :positive
    else
      :neutral
    end
  end

  # Loads the default analysis files
  def self.loadDefaults
    loadAnalysisFiles(File.dirname(__FILE__) + '/wordsAnalysis.txt')
    loadAnalysisFiles(File.dirname(__FILE__) + '/slangAnalysis.txt')
  end

  #####################################################################
  # load the specified analysis file into a hash
  #
  # filename:string -- name of file to load
  # analysishash:hash -- hash to load data into
  # return:hash -- hash with data loaded
  #####################################################################
  def self.loadAnalysisFiles(filename)
    # load the word file
    file = File.new(filename)
    while (line = file.gets)
      parsedline = line.chomp.split(/\s/)
      analysisscore = parsedline[0]
      text = parsedline[1]
      @@analysishash[text] = analysisscore.to_f
    end
    file.close
  end

  def self.threshold=(threshold)
    @@threshold = threshold
  end

end
