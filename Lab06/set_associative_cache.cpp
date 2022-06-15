#include "set_associative_cache.h"
#include "string"
#include <vector>
#include <fstream>
#include <bitset>

using namespace std;

inline int simplehash(char in){
    if(in=='0'){
        return 0;
    }
    else if(in=='1'){
        return 1;
    }
    else if(in=='2'){
        return 2;
    }
    else if(in=='3'){
        return 3;
    }
    else if(in=='4'){
        return 4;
    }
    else if(in=='5'){
        return 5;
    }
    else if(in=='6'){
        return 6;
    }
    else if(in=='7'){
        return 7;
    }
    else if(in=='8'){
        return 8;
    }
    else if(in=='9'){
        return 9;
    }
    else if(in=='a'){
        return 10;
    }
    else if(in=='b'){
        return 11;
    }
    else if(in=='c'){
        return 12;
    }
    else if(in=='d'){
        return 13;
    }
    else if(in=='e'){
        return 14;
    }
    else{
        return 15;
    }
}

int stringtoint(string in){
    int in_size=in.size()-1;
    int return_num=0;
    for(char*itt=&in[in_size];itt>=&in[0];itt--){
        return_num=return_num*2+simplehash(*itt);
    }
    return return_num;
}

float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = 0;
    int hit_num = 0;

    /*write your code HERE*/

    cache_size/=(block_size*way);
    int table_size=cache_size;
    int block_num=-1;
    int cache_num=-1;
    while(block_size!=0){
        block_size/=2;
        block_num++;
    }
    while(cache_size!=0){
        cache_size/=2;
        cache_num++;
    }
    int tag_num=(32-cache_num-block_num);

    vector<int>*table=new vector<int>[table_size];

    ifstream file_input;
    file_input.open(filename);

    string input;
    bitset<4> in;
    bitset<32> address;

    while(file_input>>input&&input.size()!=0){
        int counting=31;
        if(input.size()==7){
            while(counting!=27){
                address[counting]=0;
                counting--;
            }
        }
        for(char*itt=&input[0];itt<=&input[input.size()-1];itt++){
            in=simplehash(*itt);
            for(int i=3;i>=0;i--){
                address[counting]=in[i];
                counting--;
            }
        }
        
        string address_str=address.to_string();

        string tag,ind;
        int i=0;
        for(;i<tag_num;i++){
            tag+=address_str[i];
        }
        for(;i<=tag_num+cache_num-1;i++){
            ind+=address_str[i];
        }
        
        int tag_tag=stringtoint(tag);
        int ind_ind=stringtoint(ind);
        
        int finding=0;
        bool flag=false;
        if(table[ind_ind].size()!=0){
            for(finding;finding<=table[ind_ind].size()-1;finding++){
                if(table[ind_ind][finding]==tag_tag){
                    flag=true;
                    break;
                }
            }
        }

        if(flag){
            hit_num++;
            table[ind_ind].erase(table[ind_ind].begin()+finding);
            table[ind_ind].push_back(tag_tag);
        }
        else{
            if(table[ind_ind].size()==way){
                table[ind_ind].erase(table[ind_ind].begin());
            }
            table[ind_ind].push_back(tag_tag);
        }
        total_num++;
    }

    return (float)hit_num/total_num;
}