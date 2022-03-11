//
//  HomeView.swift
//  TaskManager
//
//  Created by Scott Clampet on 3/7/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.editMode) var editMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //MARK: Lazy Stack with Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        //MARK: Current Week Days
                        HStack(spacing: 10) {
                            ForEach(taskViewModel.currentWeek, id: \.self) { day in
                                VStack(spacing: 10) {
                                    //dd will return day as 01,02.....etc.
                                    Text(taskViewModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    //EEE will return day as MON, TUE.....etc.
                                    Text(taskViewModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskViewModel.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(taskViewModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskViewModel.isToday(date: day) ? .white : .black)
                                //MARK: Capsule Shape
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack {
                                        if taskViewModel.isToday(date: day) {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        taskViewModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    //MARK: Tasks View
                    TasksView()
                } header: {
                    HeaderView()
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        //MARK: Add Task Button
        .overlay(
            Button(action: {
                taskViewModel.showNewTaskView.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black, in: Circle())
            })
                .padding()
            , alignment: .bottomTrailing
        )
        .sheet(isPresented: $taskViewModel.showNewTaskView) {
            taskViewModel.editTask = nil
        } content: {
            NewTaskView()
                .environmentObject(taskViewModel)
        }
    }
    
    //MARK: ViewBuilders
    func HeaderView() -> some View  {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            //MARK: Edit Button
            EditButton()
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(.white)
    }
    
    func TasksView() -> some View {
        LazyVStack(spacing: 20) {
            //Converting object as our Task model
            DynamicFilteredView(dateToFilter: taskViewModel.currentDay) { (object: Task) in
                TaskCardView(task: object)
            }
        }
        .padding()
        .padding(.top)
    }
    
    func TaskCardView(task: Task) -> some View {
        HStack(alignment: editMode?.wrappedValue == .active ? .center : .top, spacing: 30) {
            if editMode?.wrappedValue == .active {
                VStack(spacing: 10) {
                    if task.date?.compare(Date()) == .orderedAscending || Calendar.current.isDateInToday(task.date ?? Date()) {
                        Button {
                            //MARK: Edit Task
                            taskViewModel.editTask = task
                            taskViewModel.showNewTaskView.toggle()
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button {
                        //MARK: Delete Task
                        context.delete(task)
                        
                        try? context.save()
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }

            } else {
                //MARK: Task Card Line
                VStack(spacing: 10) {
                    Circle()
                        .fill(taskViewModel.isCurrentHour(date: task.date ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
                        .frame(width: 15, height: 15)
                        .background(
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .padding(-3)
                        )
                        .scaleEffect(!taskViewModel.isCurrentHour(date: task.date ?? Date()) ? 0.8 : 1)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 3)
                    
                }
            }
            
            //MARK: Task Card
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(task.title ?? "")
                            .font(.title2.bold())
                        
                        Text(task.taskDescription ?? "")
                            .font(.callout)
                            .foregroundColor(taskViewModel.isCurrentHour(date: task.date ?? Date()) ? .white : .black)
                            .opacity(0.7)
                    }
                    .hLeading()
                    
                    Text(task.date?.formatted(date: .omitted, time: .shortened) ?? "")
                }
                
                if taskViewModel.isCurrentHour(date: task.date ?? Date()) {
                    HStack(spacing: 12) {
                        //MARK: Check Button
                        if !task.isCompleted {
                            Button {
                                //MARK: Update Task Status
                                task.isCompleted = true
                                
                                try? context.save()
                            } label: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(.white, in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        
                        Text(task.isCompleted ? "Task Complete" : "Mark Task as completed")
                            .font(.system(size: task.isCompleted ? 12 : 16, weight: .light))
                            .foregroundColor(.white)
                            .hLeading()

                    }
                    .padding(.top)
                }
            }
            .foregroundColor(taskViewModel.isCurrentHour(date: task.date ?? Date()) ? .white : .black)
            .padding(taskViewModel.isCurrentHour(date: task.date ?? Date()) ? 15 : 0)
            .padding(.bottom, taskViewModel.isCurrentHour(date: task.date ?? Date()) ? 0 : 10)
            .hLeading()
            .background(
                Color("Black")
                    .cornerRadius(25)
                    .opacity(taskViewModel.isCurrentHour(date: task.date ?? Date()) ? 1 : 0)
            )
        }
        .hLeading()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
