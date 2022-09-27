from main import read_csv, search, transform, create_graph
import fire


def main(keyword = None):
    film_actors = read_csv()
    if keyword is not None:
        results = search(film_actors, keyword)    
    else:
        results = film_actors
    print(f"Read {len(film_actors)} from file and found {len(results)} results.")
    graph_data = transform(results)
    create_graph(graph_data)

if __name__ == "__main__":
    fire.Fire(main)