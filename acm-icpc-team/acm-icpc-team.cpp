// ACM ICPC Team HackerRank Challenge
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Bryan DeGrendel
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

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

