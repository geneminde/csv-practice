require 'csv'
require 'awesome_print'

def get_all_olympic_athletes(filename)
  athletes = CSV.read('data/athlete_events.csv', headers: true).map { |athlete| athlete.to_h}

  athletes.each do |hash|
    hash.delete_if do |key, value|
      !%w(ID Name Height Team Year City Sport Event Medal).include?(key)
    end
  end

  return athletes
end


def total_medals_per_team(olympic_data)
  won_medals = olympic_data.filter { |hash| hash["Medal"] != "NA" }
  medals_per_team = {}
  won_medals.each do |hash|
    if medals_per_team.has_key?(hash["Team"])
      medals_per_team[hash["Team"]] += 1
    else
      medals_per_team[hash["Team"]] = 1
    end
  end
  return medals_per_team
end

def get_all_gold_medalists(olympic_data)
  gold_medals = olympic_data.filter { |hash| hash['Medal'] == "Gold" }
  return gold_medals
end

def team_with_most_medals(medals_data)
  max_medals = medals_data.max_by { |key, value| value }
  most_medals = ['Team', 'Count'].zip(max_medals)
  return most_medals.to_h
end