#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

/*
def knowledge(lookup, m, team)
  return lookup[team] if lookup.has_key? team
  count = 0
  m.times do
    count += (team & 1)
    team >>= 1
  end
  lookup[team] = count
  count
end

(n, m) = gets.split.map {|i| i.to_i }
lookup = []
people = []
max_skills = 0
count = 0
n.times { people << gets.to_i(2) }
n.times do |i|
  (i + 1..n - 1).each do |j|
    skills = knowledge(lookup, m, people[i] | people[j])
    if skills > max_skills
      max_skills = skills
      count = 0
    end
    count += 1 if skills == max_skills
  end
end
puts max_skills
puts count
*/

using namespace std;

static int knowledge(int m, int team)
{
  int skills = 0, i = team;
  for (int j = 0; j < m; j++)
  {
    skills += (i & 1);
    i >>= 1;
  }
  //cout << "team " << team << " is " << skills << endl;
  return skills;
}

int main()
{
  int n, m;
  cin >> n;
  cin >> m;
  
  string s;
  int people[n];
  
  for (int i = 0; i < n; i++)
  {
    cin >> s;
    people[i] = 0;
    for (int j = 0; j < m; j++)
    {
      people[i] <<= 1;
      if (s.at(j) == '1')
        people[i]++;
    }
  }
  
  int max_skills = 0, count = 0, skills = 0;
  
  for (int i = 0; i < n; i++)
  {
    for (int j = i + 1; j < n; j++)
    {
      //cout << "checking "  << i << " & " << j << endl;
      skills = knowledge(m, people[i] | people[j]);
      if (skills > max_skills)
      {
        max_skills = skills;
        count = 0;
      }
      if (skills == max_skills)
        count++;
    }
  }
  cout << max_skills << endl << count << endl;
  
  return 0;
}

