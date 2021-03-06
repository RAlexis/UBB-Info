package Model.Utils;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import Exception.DictionaryException;

public class MyDictionary<K, V> implements IDictionary<K, V> {

    private HashMap<K, V> dictionary;

    public MyDictionary(){
        dictionary =  new HashMap<K,V>();
    }

    @Override
    public void put(K key, V value) {
        dictionary.put(key, value);
    }

    @Override
    public void remove(K key) { dictionary.remove(key); }

    @Override
    public boolean contains(K key) {
        return dictionary.containsKey(key);
    }

    @Override
    public V get(K key) {
        if (dictionary.get(key) == null) {
            throw new DictionaryException("[Dictionary Error] Invalid key " + key + ".");
        }

        return dictionary.get(key);
    }

    @Override
    public Collection<V> values() {
        return this.dictionary.values();
    }

    @Override
    public Collection<K> keys() {
        return this.dictionary.keySet();
    }

    public String toString(){
        String s = "";
        for(K key : dictionary.keySet())
            s += key.toString() + " -> " + dictionary.get(key).toString() + "\n";
        return s;
    }

    @Override
    public IDictionary<K, V> cloneDict() {
        IDictionary<K, V> clonedDict = new MyDictionary<>();
        for (K key : this.keys())
            clonedDict.put(key, this.dictionary.get(key));
        return clonedDict;
    }

    @Override
    public Map<K, V> getMap() {
        return this.dictionary;
    }
}
