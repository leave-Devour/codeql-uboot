import cpp

class NetworkByteSwap extends Expr{
    NetworkByteSwap(){
        
        exists( MacroInvocation m1 | m1.getMacroName() in ["ntohs","ntohl" ,"ntohll"] | this =m1.getExpr())
    }
}

from NetworkByteSwap n
select n, "Network byte swap" 