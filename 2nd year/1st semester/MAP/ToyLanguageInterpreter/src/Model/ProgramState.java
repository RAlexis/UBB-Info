package Model;

import Model.Statement.IStatement;
import Model.Utils.*;

import java.io.BufferedReader;
import java.util.HashMap;

public class ProgramState {
    private MyStack<IStatement> exeStack;
    private MyList<Integer> output;
    private MyDictionary<String, Integer> symTable;
    private IStatement program;
    private MyDictionary<Integer, Tuple<String, BufferedReader>> fileTable;
    private MyHeap<Integer> heap;

    public ProgramState(IStatement program) {
        this.exeStack = new MyStack<>();
        this.output = new MyList<>();
        this.symTable = new MyDictionary<>();
        this.program = program;
        this.fileTable = new MyDictionary<>();
        this.heap = new MyHeap<Integer>(new HashMap<Integer, Integer>());

        this.exeStack.push(this.program);
    }

    public MyDictionary<String, Integer> getSymTable() {
        return this.symTable;
    }
    public void setSymTable(MyDictionary<String, Integer> symTable) {
        this.symTable = symTable;
    }

    public MyStack<IStatement> getExeStack() {
        return this.exeStack;
    }
    public void setExeStack(MyStack<IStatement> exeStack) {
        this.exeStack = exeStack;
    }

    public MyList<Integer> getOutput() {
        return this.output;
    }
    public void setOutput(MyList<Integer> output) {
        this.output = output;
    }

    public void setProgram(IStatement prg) {
        this.program = prg;
    }
    public IStatement getProgram() {
        return this.program;
    }

    public void setFileTable(MyDictionary<Integer, Tuple<String, BufferedReader>> fileTable) {
        this.fileTable = fileTable;
    }

    public MyDictionary<Integer, Tuple<String, BufferedReader>> getFileTable() {
        return this.fileTable;
    }

    public void setHeap(MyHeap<Integer> heap) {
        this.heap = heap;
    }

    public MyHeap<Integer> getHeap() {
        return this.heap;
    }

    public String toString() {
        String s = "";
        s += "exeStack:\n";
        s += this.exeStack.toString();
        s += "\nsymTable:\n";
        s += this.symTable.toString();
        s += "\noutput:\n";
        s += this.output.toString();
        s += "\nfileTable:\n";
        s += this.fileTable.toString();
        s += "\nheap:\n";
        s += this.heap.toString();
        s += "\n--------------------------------\n";

        return s;
    }


}
