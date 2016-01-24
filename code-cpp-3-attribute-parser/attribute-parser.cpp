#include <unordered_map>
#include <iostream>
#include <sstream>

using namespace std;

struct Tag
{
  Tag(string name, Tag *parent) : name(name), parent(parent)
  {
  }

  string name;
  unordered_map<string, Tag *> children;
  unordered_map<string, string> attributes;
  Tag *parent;
};

bool search(Tag *scope, string line, string &result)
{
  string chunk;
  size_t pos = line.find('.');

  cerr << "Searching for " << line << " in " << scope->name << endl;

  if (pos == string::npos)
    pos = line.find('~');

  if (pos == string::npos)
  {
    cerr << "Final step for " << line << endl;
    if (scope->attributes.count(line) == 0)
      return false;
    result = scope->attributes[line];
    return true;
  }
  else
  {
    chunk = line.substr(0, pos);
    if (scope->children.count(chunk) == 0)
      return false;
    return search(scope->children[chunk], line.substr(pos + 1), result);
  }
}

int main()
{
  int N, Q;
  Tag root("[root]", NULL);
  Tag *current = &root, *tag;
  string line, chunk, name, value;
  stringstream ss;
  cin >> N;
  cin >> Q;

  getline(cin, line);

  for (int i = 0; i < N; i++)
  {
    getline(cin, line);
    cerr << "Reading line " << line << endl;
    if (line.find("</") == 0)
    {
      cerr << "Closing tag " << current->name << " to " << current->parent->name << endl;
      current = current->parent;
    }
    else
    {
      ss.clear();
      ss.str(line);
      ss >> chunk;
      name = chunk.substr(1);
      if (name.back() == '>')
      {
        name = name.substr(0, name.length() - 1);
        tag = new Tag(name, current);
        cerr << "Opening no attribute tag " << name << endl;
      }
      else
      {
        tag = new Tag(name, current);
        cerr << "Opening attribute tag " << name << endl;
        while (true)
        {
          ss >> name;
          ss >> chunk;
          ss >> chunk;
          value = chunk.substr(1, chunk.find("\"", 1) - 1);

          tag->attributes[name] = value;

          cerr << "Adding attribute " << name << ".." << value << endl;

          if (chunk.back() == '>')
            break;
        }
      }
      current->children[tag->name] = tag;
      current = tag;
    }
  }

  for (int i = 0; i < Q; i++)
  {
    getline(cin, line);
    if (!search(&root, line, value))
      cout << "Not Found!" << endl;
    else
      cout << value << endl;
  }
  return 0;
}

