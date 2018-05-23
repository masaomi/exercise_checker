# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_problem(name, question)
  problem = Problem.new
  problem.name = name
  problem.question = question[0]
  problem.answer_src = question[1]
  problem.answer_out = question[2]
  if question[3]
    problem.arguments = question[3]
  else
    problem.arguments = ""
  end
  problem.save
end

problems = {
  "Day1 Part1 Exercise1" => ["Calculate mean of list elements", "day1_1_exercise1.py", "day1_1_exercise1.out"],
  "Day1 Part1 Exercise2" => ["Calculate standard deviation of list elements", "day1_1_exercise2.py", "day1_1_exercise2.out"],
  "Day1 Part1 Advanced1" => ["Calculate the number of combinations and permutations", "day1_1_advanced1.py", "day1_1_advanced1.out", ""],

#  "Day1 Part2 Exercise1" => ["Compare two nucleotide sequences and count the number of same and different nucleotides at each position", "day1_2_exercise1.py", "day1_2_exercise1.out", ""],
#  "Day1 Part2 Advanced1" => ["Implement a simple sequence search algorithm", "day1_2_advanced1.py", "day1_2_advanced1.out", ""],
#  "Day1 Part2 Advanced2" => ["Make a complementary strand of a nucleotide sequence", "day1_2_advanced2.py", "day1_2_advanced2.out", ""],

#  "Day1 Part3 Exercise1" => ["Pair-wise comparison of 3 sequences", "day1_3_exercise1.py", "day1_3_exercise1.out", ""],
#  "Day1 Part3 Exercise2" => ["Pair-wise comparison of 3 sequences and print the total number of different nucleotides at each position", "day1_3_exercise2.py", "day1_3_exercise2.out", ""],
#  "Day1 Part3 Advanced1" => ["Calculate nucleotide diversity of 3 sequences", "day1_3_advanced1.py", "day1_3_advanced1.out", ""],

#  "Day2 part1 Exercise1" => ["Load a fasta file and calc genome size (this will take some time)", "day2_1_exercise1.py", "day2_1_exercise1.out", "answers/athal_genome.fa"], 
#  "Day2 part1 Advanced1" => ["GC content, A. thaliana genome (this will take some time)", "day2_1_advanced1.py", "day2_1_advanced1.out", "answers/athal_genome.fa"],
#  "Day2 part1 Advanced2" => ["GC content, Load a fastq file", "day2_1_advanced2.py", "day2_1_advanced2.out", "answers/sample.fq"],

#  "Day2 part2 Exercise1" => ["Nucleotide diversity from fasta", "day2_2_exercise1.py", "day2_2_exercise1.out", "answers/input.fa"],
#  "Day2 part2 Advanced1" => ["Function load fasta and nucleotide diversity", "day2_2_advanced1.py", "day2_2_advanced1.out", "answers/input.fa"],

#  "Day2 part3 Exercise1" => ["Segregating sites", "day2_3_exercise1.py", "day2_3_exercise1.out", "answers/input.fa"],
#  "Day2 part3 Advanced1" => ["Function segregating sites", "day2_3_advanced1.py", "day2_3_advanced1.out", "answers/input.fa"],
#  "Day2 part3 Advanced2" => ["calc MAF, Minor Allele Frequency", "day2_3_advanced2.py", "day2_3_advanced2.out", "answers/input.fa"],
#
#  "Day2 part4 Exercise1" => ["Tajima's D", "day2_4_exercise1.py", "day2_4_exercise1.out", "answers/input.fa"],
#  "Day2 part4 Advanced1" => ["Function Tajima's D", "day2_4_advanced1.py", "day2_4_advanced1.out", "answers/input.fa"],
#
#  "Day2 part5 Exercise1" => ["Tajima's D A. kamchatica, assuming that answers/tajimas_d.py is called in the batch python script", "day2_5_exercise1.py", "day2_5_exercise1.out", "answers/HMA4_aligned_fasta_Ahal_origin"],
#
#  "Day2 part5 Advanced1" => ["Tajima's D A. thaliana", "day2_5_advanced1.py", "day2_5_advanced1.out", ""],

#
#  "Course level" => "Was the problem difficulty sutable for you? (difficult 5 - 0 easy)",
#  "Course speed" => "Was the course speed fast or slow? (fast 5 - 0 slow)",
#  "Explanation" => "Did the instructor expain efficiently? (good 5 - 0 bad)",
#  "Contents" => "Did the instructor expain efficiently? (good 5 - 0 bad)",
#  "Comments" => "Please give an advice for the course next year? (whatever)",

}

problems.each do |name, question|
  create_problem(name, question)
end
