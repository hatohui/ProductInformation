package interfaces;

import java.util.List;

public interface Workable<T> {

  public List<T> getAll();

  public void post(T object);

  public T update(String id, T object);

  public T delete(T object);

  public T getById(String id);
}
