import csv

def read_csv():
    result = []
    with open('film_actors.csv', mode ='r')as file:
        reader = csv.reader(file, delimiter=';')
        header = []
        for line in reader:
            if len(header) == 0:
                header = line
            else:
                item = {}
                for i in range(len(header)):
                    item[header[i]] = line[i]
                result.append(item)
    return result


def search(list, keyword):
    result = []
    for item in list:
        if keyword in item['actor_name']:
            result.append(item)
    return result


def transform(list):
    result = {}
    for item in list:
        if item['actor_name'] not in result:
            result[item['actor_name']] = 0
        result[item['actor_name']] += 1
    return dict(sorted(result.items(), key=lambda r: r[1]))


def create_graph(data):
    with open('chart.txt', 'w') as file:
        for name, count in data.items():
            file.write(f"{name:30} {'='*count}\n")


def main():
    film_actors = read_csv()
    print(f"Read {len(film_actors)} from file.")
    keyword = input("What is the name you want to search on: ")
    if keyword != '':
        results = search(film_actors, keyword)    
    else:
        results = film_actors
    print(f"Found {len(results)} results in file.")
    graph_data = transform(results)
    print(graph_data)
    create_graph(graph_data)


if __name__ == "__main__" :
    main()
