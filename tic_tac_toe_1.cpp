#include <bits/stdc++.h>
using namespace std;

int calculateValue(vector<vector<char>>&v){
    //row wise
    for(int i=0 ; i<3 ;++i){
        if(v[i][0]==v[i][1] && v[i][1]==v[i][2]){
            if(v[i][0]=='X')
                return 10;
            else 
                return -10;
        }
    }
    //column wise
    for(int i=0 ; i<3 ;++i){
        if(v[0][i]==v[1][i] && v[1][i]==v[2][i]){
            if(v[0][i]=='X')
                return 10;
            else 
                return -10;
        }
    }
    //first diagonal 
   
        if(v[1][1]==v[0][0] && v[1][1]==v[2][2]){
            if(v[1][1]=='X')
                return 10;
            else 
                return -10;
        }
    
    //second diagonal
    if(v[1][1]==v[2][0] && v[1][1]==v[0][2]){
            if(v[1][1]=='X')
                return 10;
            else 
                return -10;
        }
        
        return 0;//we can return 0 or 1
}
int main() {
	// your code goes here
	vector<vector<char>> v(3,vector<char>(3));
	for(int i=0 ;i<3 ;++i){
	    for(int j=0 ;j<3 ;++j){
	        cin>>v[i][j];
	    }
	}
	
	int val=calculateValue(v);
	cout<<val<<endl;

}
