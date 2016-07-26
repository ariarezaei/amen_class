#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <algorithm>
#include <string>
using namespace std;
typedef pair<int, int> pii;


int MAXN = 1000 * 1000 + 10;


vector< vector<int> > adj;		// The adjacency list for each node
vector<bool> mark;				// Mark for BFS
vector<int> comp;				// Component number for each node
vector<int> compSize;			// Component size
vector<pii> edges;				// All edges

inline int bfs(int source, int compInd)
{
    int size = 0;
    queue<int> q;

	// Adding source to Queue
	q.push(source);
	mark[source] = true;
	comp[source] = compInd;
	size += 1;

	while (q.empty() == false)
	{
		int v = q.front();
		q.pop();
		for (int i = 0; i < (int)adj[v].size(); i++)
		{
			int u = adj[v][i];
			if (mark[u] == false)
			{
				q.push(u);
				mark[u] = true;
				comp[u] = compInd;
				size += 1;
			}
		}
	}
    
    return size;
}

inline void initialize(int n)
{
	for (int i = 0; i < n; i++)
    {
		// Initializing adjacency list
        vector<int> thisAdj;
        adj.push_back(thisAdj);

		// Initializing mark vector
		mark.push_back(false);

		// Initializing components
		comp.push_back(-1);
    }
}

inline void sortUnique(vector<int>& v)
{
	sort(v.begin(), v.end());
	vector<int>::iterator newEnd = unique(v.begin(), v.end());
	v.resize(newEnd - v.begin());
}

inline int matlabToCpp(int ind)
{
	return ind - 1;
}

inline int cppToMatlab(int ind)
{
	return ind + 1;
}


int main(int argc, char** argv)
{
	if (argc != 3)
	{
		cerr << "Wrong arguments" << endl;
		for (int i = 0; i < argc; i++)
			cerr << "\t" << argv[i] << endl;
		return 0;
	}

	ifstream edgeFile;
	edgeFile.open(argv[1], ifstream::in);

	int N = -1;
	int E = 0;
	while (edgeFile.eof() == false)
	{
		int u, v;
		edgeFile >> u >> v;
		u = matlabToCpp(u);
		v = matlabToCpp(v);

		edges.push_back(pair<int, int>(u, v));
		N = max(N, u + 1);
		N = max(N, v + 1);

		// Adding to the number of edges
		E += 1;
	}
	edgeFile.close();

	initialize(N);
	for (int i = 0; i < E; i++)
	{
		int u = edges[i].first;
		int v = edges[i].second;

		adj[u].push_back(v);
		adj[v].push_back(u);
	}

	// Removing redundancies from adjacency list
	for (int i = 0; i < N; i++)
		sortUnique(adj[i]);

	// Doing BFS and finding components
	int compInd = 0;
	for (int i = 0; i < N; i++)
		if (mark[i] == true)
			continue;
		else
		{
			int curSize = bfs(i, compInd);
			compSize.push_back(curSize);
			compInd += 1;
		}
	ofstream compFile;
	compFile.open(argv[2], ofstream::out);

	int maxCompSize = -1;
	int maxCompInd = -1;

	for (int i = 0; i < (int)compSize.size(); i++)
		if (compSize[i] > maxCompSize)
		{
			maxCompSize = compSize[i];
			maxCompInd = i;
		}

	cerr << "Biggest component: " << maxCompInd+1 << "\tSize: " << maxCompSize << endl;

	for (int i = 0; i < N; i++)
		if (comp[i] == maxCompInd)
			compFile << cppToMatlab(i) << endl;

	compFile.close();

	return 0;
}