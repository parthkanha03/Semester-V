#include <bits/stdc++.h>
using namespace std;
typedef pair<int, string> P; // cost, node
typedef unordered_map<string, vector<pair<string, int>>> G;

vector<string> rp(unordered_map<string, string>& p, string g) {
    vector<string> r;
    while (g != "") {
        r.push_back(g);
        g = p[g];
    }
    reverse(r.begin(), r.end());
    return r;
}

void ucs(const G& g, const string& s, const string& e) {
    priority_queue<P, vector<P>, greater<P>> q;
    unordered_map<string, int> c;
    unordered_map<string, string> p;
    set<string> x;
    q.push({0, s});
    c[s] = 0;
    p[s] = "";
    int ne = 0;
    while (!q.empty()) {
        auto [cost, n] = q.top(); q.pop();
        if (x.count(n)) continue;
        x.insert(n);
        ne++;
        if (n == e) break;
        for (auto& [nb, ec] : g.at(n)) {
            int nc = cost + ec;
            if (!c.count(nb) || nc < c[nb]) {
                c[nb] = nc;
                p[nb] = n;
                q.push({nc, nb});
            }
        }
    }
    if (!p.count(e)) return;
    vector<string> path = rp(p, e);
    for (size_t i = 0; i < path.size(); ++i) {
        cout << path[i];
        if (i + 1 < path.size()) cout << " ";
    }
    cout << endl << c[e] << endl << ne << endl;
}

void astar(const G& g, const string& s, const string& e, unordered_map<string, int>& h) {
    priority_queue<P, vector<P>, greater<P>> q;
    unordered_map<string, int> c;
    unordered_map<string, string> p;
    set<string> x;
    q.push({h[s], s});
    c[s] = 0;
    p[s] = "";
    int ne = 0;
    while (!q.empty()) {
        auto [f, n] = q.top(); q.pop();
        if (x.count(n)) continue;
        x.insert(n);
        ne++;
        if (n == e) break;
        for (auto& [nb, ec] : g.at(n)) {
            int nc = c[n] + ec;
            if (!c.count(nb) || nc < c[nb]) {
                c[nb] = nc;
                p[nb] = n;
                q.push({nc + h[nb], nb});
            }
        }
    }
    if (!p.count(e)) return;
    vector<string> path = rp(p, e);
    for (size_t i = 0; i < path.size(); ++i) {
        cout << path[i];
        if (i + 1 < path.size()) cout << " ";
    }
    cout << endl << c[e] << endl << ne << endl;
}

int main() {
    G g;
    string s, e;
    int ne;
    cin >> s >> e >> ne;
    for (int i = 0; i < ne; ++i) {
        string u, v; int c;
        cin >> u >> v >> c;
        g[u].push_back({v, c});
    }
    ucs(g, s, e);
    string ans;
    cin >> ans;
    if (ans == "y" || ans == "Y") {
        unordered_map<string, int> h;
        int hc;
        cin >> hc;
        for (int i = 0; i < hc; ++i) {
            string n; int v;
            cin >> n >> v;
            h[n] = v;
        }
        astar(g, s, e, h);
    }
    return 0;
}
