module Torre
  module Parser
    class BioService
      def self.bio(bio_response:)
        {
          profile:   get_profile(bio_response: bio_response),
          stats:     bio_response["stats"],
          strenghts: get_strengths(bio_response: bio_response),
          interest:  get_interests(bio_response: bio_response)
        }
      end

      def self.get_profile(bio_response:)
        {
          name:                  bio_response.dig("person","name"),
          professional_headline: bio_response.dig("person","professionalHeadline"),
          created_in_torre:      bio_response.dig("person","created"),
          verified:              bio_response.dig("person","verified"),
          score:                 bio_response.dig("person","weight"),
          picture_url:           bio_response.dig("person","picture"),
          location: {
            name:      bio_response.dig("person", "location", "name"),
            latitude:  bio_response.dig("person", "location", "latitude"),
            longitude: bio_response.dig("person", "location", "longitude")
          },
          summary: bio_response["summaryOfBio"]
        }
      end

      def self.get_strengths(bio_response:)
        bio_response["strengths"].map do |strength|
          {
            name:            strength["name"],
            weight:          strength["weight"],
            recommendations: strength["recommendations"]
          }
        end
      end

      def self.get_interests(bio_response:)
        {
          industries: parse_industries(bio_industries: bio_response["opportunities"].select{|type| type["interest"] == "industries" }.first)
        }
      end

      def self.parse_industries(bio_industries:)
        bio_industries["data"].map {|industry| industry["name"]}
      end
    end
  end
end
