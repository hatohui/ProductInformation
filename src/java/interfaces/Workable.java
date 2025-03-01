package interfaces;

import java.util.List;

public interface Workable<T> {

    public List<T> getAll();

    public void post(T object);

    public T update(String id, T object);

    public boolean delete(String id);

    public T getById(String id);
}
