#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

static int knowledge(int m, string one, string two)
{
  int skills = 0;
  for (int i = 0; i < m; i++)
  {
    if (one.at(i) == '1' || two.at(i) == '1')
      skills++;
  }
  //cout << "one " << one << " two " << two << " is " << skills << endl;
  return skills;
}

int main()
{
  int n, m;
  cin >> n;
  cin >> m;
  
  string s;
  vector<string> people;
  
  for (int i = 0; i < n; i++)
  {
    cin >> s;
    people.push_back(s);
    //cout << "person " << i << " is " << people[i] << endl;
  }
  
  int max_skills = 0, count = 0, skills = 0;
  
  for (int i = 0; i < n; i++)
  {
    for (int j = i + 1; j < n; j++)
    {
      //cout << "checking "  << i << " [" << people[i] << "] & " << j << " [" << people[j] << "]" << endl;
      skills = knowledge(m, people[i], people[j]);
      if (skills > max_skills)
      {
        //cout << "new high of " << skills << " old is " << max_skills << endl;
        max_skills = skills;
        count = 0;
      }
      if (skills == max_skills)
      {
        count++;
        //cout << "add to " << max_skills << " now " << count << endl;
      }
    }
  }
  cout << max_skills << endl << count << endl;
  
  return 0;
}

