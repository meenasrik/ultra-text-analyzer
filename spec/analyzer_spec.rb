require "./ultra_text_analyzer"

RSpec.describe UltraTextAnalyzer do
  describe ".analyze" do

    describe "when counting contractable phrases" do
      it "should find a word followed by 'is' without punctuation between them" do
        expect(UltraTextAnalyzer.analyze("She is cool.")).to include("Contractable phrases: 1")
      end

      it "should count 'let us' as a contractable phrase" do
        expect(UltraTextAnalyzer.analyze("Let us celebrate.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("Please let us go.")).to include("Contractable phrases: 1")
      end

      it "should find I followed by [am, have, would, had, will]" do
        expect(UltraTextAnalyzer.analyze("I am a student.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("I have an idea.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("I would help you.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("I had a reason.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("I will bring the book.")).to include("Contractable phrases: 1")
      end

      it "should find 'are' preceded by [you, they, we]" do
        expect(UltraTextAnalyzer.analyze("You are fine.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("They are ready.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("We are doing good.")).to include("Contractable phrases: 1")
      end

      it "should find 'not' preceded by [must, might, should, could, did, do, would, will, had, has, have, were, was, are, is]" do
        expect(UltraTextAnalyzer.analyze("I might not come.")).to include("Contractable phrases: 1")
        expect(UltraTextAnalyzer.analyze("She was not there.")).to include("Contractable phrases: 1")
      end

      it "should find 'will' preceded by [you, he, she, it, we, they, that, who, what, where, when, why, how]" do  
        expect(UltraTextAnalyzer.analyze("Are you sure they will too?")).to include("Contractable phrases: 1")
      end

      it "should find 'have' preceded by [you, we, they]" do
        expect(UltraTextAnalyzer.analyze("You have a chance.")).to include("Contractable phrases: 1")
      end

      it "should find 'has' preceded by [he, she, it, that, who, what, where, when, why, how]" do
        expect(UltraTextAnalyzer.analyze("You have a chance.")).to include("Contractable phrases: 1")
      end

      it "should find 'had' preceded by [you, he, she, it, we, they, that, who, what, where, when, why, how]" do
        expect(UltraTextAnalyzer.analyze("You had a chance.")).to include("Contractable phrases: 1")
      end

      it "should find 'would' preceded by [you, he, she, it, we, they, that, who, what, where, when, why, how]" do
        expect(UltraTextAnalyzer.analyze("That would be good.")).to include("Contractable phrases: 1")
      end

      it "should count 'cannot' as contractable phrase" do
        expect(UltraTextAnalyzer.analyze("I cannot come.")).to include("Contractable phrases: 1")
      end
    end

    let(:long_text) { "Hey how are you doing? Have you seen Bob lately? Lately I heard  he was doing a new job, but I'm not sure what. Susan was in Europe last week for her job for vacation. Have you talked to her? Lately she's been hard to catch up with. What have y'all been doing lately?" }

    it "should output the correct word count" do
      results = UltraTextAnalyzer.analyze(" hello,   my friend   ")
      expect(results).to include("3 words")
    end

    it "should output the correct character count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("17 characters")
    end

    it "should output the correct space count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("2 spaces")
    end

    it "should output the correct space count even with leading, trailing, abnormal spacing" do
      results = UltraTextAnalyzer.analyze("  hello,  my    friend.     ")  
      expect(results).to include("13 spaces")
    end    

    it "should output the most common word, regardless of capitalization" do
      results = UltraTextAnalyzer.analyze(long_text)
      expect(results).to include("Most common word: lately")
    end

    it "should output the longest word" do
      results = UltraTextAnalyzer.analyze(long_text)
      expect(results).to include("Longest word: vacation")
    end

    it "should output the longest word regardless of adjacent special characters" do
      results = UltraTextAnalyzer.analyze("sushi bowl....")
      expect(results).to include("Longest word: sushi")
    end

    it "should return nil for any argument not a string" do
      results = UltraTextAnalyzer.analyze(123)
      expect(results).to be_nil
    end
  end
end
