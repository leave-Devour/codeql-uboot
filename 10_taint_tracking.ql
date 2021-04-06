import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
class NetworkByteSwap extends Expr{
    NetworkByteSwap(){
        
        exists( MacroInvocation m1 | m1.getMacroName() in ["ntohs","ntohl" ,"ntohll"] | this =m1.getExpr())
    }
}

class Config extends TaintTracking::Configuration{
    Config(){
        this ="NetworkToMemFuncLength"
    }
    override predicate isSource(DataFlow::Node source){
        source.asExpr() instanceof NetworkByteSwap

    }
    override predicate isSink(DataFlow:: Node sink){
        //sink.asExpr().(FunctionCall).getTarget().getName()="memcpy"  and sink.asExpr() = c.getArgument(2)
        exists(FunctionCall c | c.getTarget().getName() = "memcpy" and sink.asExpr() = c.getArgument(2))
    }

}

from Config cfg, DataFlow::PathNode source,DataFlow::PathNode sink
where cfg.hasFlowPath(source,sink)
select sink,source,sink,"Network byte swap flows to memcpy"